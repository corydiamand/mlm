module PortalUpdates

	require 'net/http'
	require 'net/https'
	require 'nokogiri'
	require 'json'

	class String
	  def to_fmquery
	    "-" + URI.encode(self)
	  end    
	end

	class Catalyst

	  attr_accessor :base_uri, :db, :layout

	  def initialize(base_uri = 'http://100.1.53.23:4120/fmi/xml/fmresultset.xml/', db = "Catalyst 2.0")
	    @base_uri = URI(base_uri)
	    @db = db
	  end

	  def db
	    "db=#{@db}".to_fmquery
	  end

	  def layout
	    "lay=#{@layout}".to_fmquery
	  end

	  def convert_to_query(hash)
	    query_string = "" 
	    hash.each do |key, value|
	      query_string << "#{key=value}".to_fmquery
	    end
	    print query_string
	  end


	  def do_action(base_uri, db, layout, action =  "", fields = {})
	    fields_string = ""
	    query = "?" << db << "&" << layout
	    fields.each do |key, value|
	      fields_string << "&" << URI.encode(key.to_s) << "=" << URI.encode(value.to_s)
	    end
	    query << fields_string << "&" << action.to_fmquery unless action.empty?
	    do_request(base_uri, query)
	  end   

	  def do_request(base_uri, query)
	    begin
	      Net::HTTP.get_response(base_uri + query) 
	    rescue
	      raise "Unable to contact filemaker database."
	    end
	  end
	  
	  def db_names
	    db_names = []
	    request = do_request(@base_uri, "?-dbnames")
	    body = Nokogiri::XML::Document.parse(request.body)
	    body.xpath('//xmlns:data').each { |db_node| db_names << db_node.text }
	    return db_names
	  end

	  def layout_names
	    layout_names = []
	    request = do_action(@base_uri, db, '-layoutnames')
	    body = Nokogiri::XML::Document.parse(request.body)
	    body.xpath('//xmlns:data').each { |lay_node| layout_names << lay_node.text }
	    return layout_names
	  end

	  def field_names
	    if @layout
	      field_names = []
	      request = do_action(@base_uri, db, layout, "view")
	      body = Nokogiri::XML::Document.parse(request.body)
	      body.xpath('//xmlns:field-definition/@name').each do |field_node| 
	        field_names << field_node.text
	      end
	      return field_names
	    else
	      raise "No Layout!"
	    end
	  end

	  def get_new_works
	    self.layout = "Works Catalog"
	    works = []
	    request = do_action(@base_uri, db, layout, "find", portal_tag: 1)
	    body = Nokogiri::XML::Document.parse(request.body).remove_namespaces!
	    songs = body.xpath("//resultset/record")
	    songs.each do |song|
	      title = song.xpath("field[@name='work_title']").text
	      duration = song.xpath("field[@name='duration']").text
	      copyright_date = song.xpath("field[@name='copyright_date']").text
	      new_work = Work.new(title: title, duration: duration, copyright_date: copyright_date)
	      works << new_work
	    end
	    return works
	  end

	  def get_new_users
	    self.layout = "Payees"
	    users = []
	    request = do_action(@base_uri, db, layout, "find", portal_tag: 1)
	    body = Nokogiri::XML::Document.parse(request.body).remove_namespaces!
	    payees = body.xpath("//resultset/record")
	    payees.each do |user|
	      first_name = user.xpath("field[@name='payee_first']").text
	      last_name = user.xpath("field[@name='payee_last']").text
	      email = user.xpath("field[@name='email_username']").text
	      area_code = user.xpath("field[@name='area_code']").text
	      phone_number = user.xpath("field[@name='phone_number']").text
	      apartment_number = user.xpath("field[@name='apartment_number']").text
	      address_number = user.xpath("field[@name='address_number']").text
	      street_name = user.xpath("field[@name='street']").text
	      city = user.xpath("field[@name='city']").text
	      state = user.xpath("field[@name='state']").text
	      zip_code = user.xpath("field[@name='zip']").text
	      password = user.xpath("field[@name='temp_password']").text
	      new_user = {
	        user: {
	          first_name: first_name,
	          last_name: last_name,
	          email: email,
	          area_code: area_code,
	          phone_number: phone_number,
	          apartment_number: apartment_number,
	          address_number: address_number,
	          street_name: street_name,
	          city: city,
	          state: state,
	          zip_code: zip_code,
	          password: password,
	          password_confirmation: password
	        }
	      }
	      users << new_user
	    end
	    return users
	  end

	  def get_new_statements
	    self.layout = "Statements"
	    statements = []
	    request = do_action(@base_uri, db, layout, "find", portal_tag: 1)
	    body = Nokogiri::XML::Document.parse(request.body).remove_namespaces!
	    fmstatements = body.xpath("//resultset/record")
	    fmstatements.each do |statement|
	      user_id = statement.xpath("field[@name='web_id']").text
	      quarter = statement.xpath("field[@name='quarter']").text
	      year = statement.xpath("field[@name='year']").text
	      amount = statement.xpath("field[@name='amount']").text
	      filename = statement.xpath("field[@name='filename']").text
	      date_string = statement.xpath("field[@name='date']").text
	      new_statement = {
	        statement: {
	          user_id: user_id,
	          quarter: quarter,
	          year: year,
	          amount: amount,
	          filename: filename,
	          date_string: date_string
	        }
	      }
	      statements << new_statement
	    end
	    return statements
	  end

	  def post_new_users
	    url = "http://localhost:3000/users"
	    uri = URI.parse(url)
	    users = get_new_users
	    headers = {"Content-Type" => "application/json"}
	    http = Net::HTTP.new(uri.host, uri.port)
	    users.each do  |user|	    
	    	new_user = ::User.new(user[:user])
	    	new_user.save
	    	puts "user saved!"
	    end
	  end

	  def post_new_statements
	    url = "http://localhost:3000/users"
	    uri = URI.parse(url)
	    statements = get_new_statements
	    headers = {"Content-Type" => "application/json"}
	    http = Net::HTTP.new(uri.host, uri.port)
	    statements.each do  |statement|	    
	    	new_statement = ::Statement.new(statement[:statement]) 	
	    		new_statement.save!
	    		puts statement.inspect
	    		puts "Statement Saved!"
	    end
	  end


	  #   new_users = get_new_users
	  #   uri = URI("http://localhost:3000/users")
	  #   res = Net::HTTP.start(uri.hostname, uri.port) do |http|
	  #     req = Net::HTTP::Post.new(uri.to_s, initheader = {'Content-Type' =>'application/json'})
	  #     req.set_form_data(JSON.parse(new_users[0]))
	  #     http.request(req)
	  #   end
	  # end
	end
	puts "past Catalyst class"

	class Work

	  attr_accessor :title, :duration, :copyright_date

	  def initialize(attributes = {})
	    attributes.each do |key, value|
	      instance_eval("self.#{key} = value")
	    end
	  end
	end
	puts "past Work class"

	class User

	  attr_accessor :first_name, :last_name, :email, :area_code, :phone_number,
	                :apartment_number, :address_number, :street_name, :city,
	                :state, :zip_code, :password, :password_confirmation

	  def initialize(attributes = {})
	    attributes.each do |key, value|
	      instance_eval("self.#{key} = value")
	    end
	  end
	end
	puts "past User class"
	class Statement

	  attr_accessor :user_id, :quarter, :year, :amount, :filename, :date_string

	  def initialize(attributes = {})
	    attributes.each do |key, value|
	      instance_eval("self.#{key} = value")
	    end
	  end
	end
	puts "past Statement class"


	#make this less scripty?
	######### Delete this whenever  ###########
	
	#database = Catalyst.new
	#database.post_new_users
	#database.post_new_statements
	

	puts "past Catalyst where it posts to database"



	# class Result < Nokogiri::XML::Element

	#   attr_accessor :element

	#   def initialize(element)
	#     self.element = element
	#     super()
	#   end

	# end

	# class ResultSet

	#   attr_accessor :results

	#   def initialize(body)
	#     body.each do |element|
	#       self.results << Result.new(element)
	#     end
	#   end

	#   def each(&block)
	#     results.each(&block)
	#   end

	# end

end
module PortalSync
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
	    request = do_action(@base_uri, db, layout, "find") #removed query string and now displays all users.
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
	      web_id = user.xpath("field[@name='web_id']").text
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
	          password_confirmation: password,
	          web_id: web_id
	        }
	      }
	      users << new_user
	    end
	    return users
	  end

	  def post_new_users
	    url = "http://localhost:3000/users"
	    uri = URI.parse(url)
	    users = get_new_users
	    headers = {"Content-Type" => "application/json"}
	    http = Net::HTTP.new(uri.host, uri.port)
	    nil_count = 0
	    nil_email = []
	    users.each do  |user|	    
	    	#new_user = ::User.new(user[:user])
	    	#new_user.save
	    	#site_user = ::User.where(:email => user[:user][:email].downcase.gsub(/\s+/, "").delete(" ")).last
	    	site_user = ::User.where("email = lower(?)", user[:user][:email].downcase.gsub(/\s+/, "")).first
	    	#puts site_user.inspect

	    	
	    	if site_user == nil
	    		site_user = ::User.where(:first_name => user[:user][:first_name].upcase, :last_name => user[:user][:last_name].upcase ).first
	    		if ::User.where(:first_name => user[:user][:first_name].upcase, :last_name => user[:user][:last_name].upcase ).length > 1
	    			puts "DUPLICATES"
	    		elsif site_user == nil
		    		puts "no user associated with email address: #{user[:user][:email]} web_id: #{user[:user][:web_id]}"
		    		nil_count += 1
		    		nil_email.push(user[:user][:email])
		    		nil_email.push(user[:user][:web_id])
	    		else
	    			if site_user.web_id.nil?
	    			puts "Site user #{site_user.id}'s web id is being updated to #{user[:user][:web_id]} because first name and last name match"
	    			site_user.web_id = user[:user][:web_id]
	    			site_user.update_attribute(:web_id, user[:user][:web_id])
	    			else
	    				puts "user alread has web_id #{site_user.web_id}"
	    			end
	    		end
	    	elsif site_user.web_id
	    		puts "User already has web_id #{site_user.web_id}"
	    		if user[:user][:web_id] == site_user.web_id.inspect
	    			puts "Web_id's match"
	    		else
	    			puts "WARNING WEB_IDS DONT MATCH!!!!! remote web_id = #{user[:user][:web_id]} & local_id = #{site_user.web_id}"
	    		end
	    	else
	    		puts "Site user #{site_user.id}'s web id is being updated to #{user[:user][:web_id]}"
	    		site_user.web_id = user[:user][:web_id]
	    		begin
	    			site_user.update_attribute(:web_id, user[:user][:web_id])
	    		rescue Exception => e
	    			puts e
	    			next
	    		end
	    	end
	    end
	    puts "Nil counts = #{nil_count}"
	    puts nil_email.inspect
	  end

	  ::Statement.where("user_id is not null").each do |statement|
	  	statement.update_attribute(:web_id, statement.user_id)
	  end


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
	
	database = Catalyst.new
	database.post_new_users
	#database.post_new_statements
	

	puts "past Catalyst where it posts to database"
end




module fmpsupport

  filenames = { 'users.csv': "\"first_name\",\"last_name\"\n", 
                'claims.csv': "\"user_id\",\"work_id\",\"mr_share\"\n" ,
                'works.csv': "\"title\",\"duration\",\"copyright_date\"\n" ,
                'audio_products.csv': "\"work_id\",\"artist\",\"album\",\"label\",\"catalog_number\"\n"  }

  def name_columns
    filenames.each do |file|
      File.open(file.key, 'r')
      text = file.read
      file.close
      File.open(file.key, 'w')
      file.write("#{file.value}#{text}")
      file.close
    end
  end
end
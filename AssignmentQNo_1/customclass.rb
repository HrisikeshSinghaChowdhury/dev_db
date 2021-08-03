# => Import the files
require_relative 'dbskeletonclass.rb'
require_relative 'checkvaliddateskeleton.rb'

# => custom class
class CustomClass
  def custom_method
    puts "Enter the dbname"
    dbname = gets.chomp
    puts "Enter the username"
    username = gets.chomp
    puts "Enter the password"
    password = gets.chomp
    puts "Enter the starting date format (dd/mm/yyyy)"
    start_date = gets.chomp
    puts "Enter the ending date (dd/mm/yyyy)"
    end_date = gets.chomp
    obDate = CheckValidDateSkeleton.new
    # => check start date valid or not.If invalid program terminates
    obDate.chkDate(start_date)
    # => check end date valid or not.If invalid program terminates
    obDate.chkDate(end_date)
    puts "The employee details with the employee credentials entered here"
    puts "---------------------------------------------------"
    ob = DBSkeletonClass.new(dbname, username, password)
    ob.process_method(start_date, end_date)
    puts "Path = #{Dir.pwd}.Employee Details and his/her projects between these date
                 are exported to Sample.CSV file i the same folder"
    puts "---------------------------------------------------"
  end
end

CustomClass.new.custom_method

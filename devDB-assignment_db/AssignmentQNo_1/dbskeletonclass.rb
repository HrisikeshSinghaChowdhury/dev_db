# => import the libraries
require 'pg'
require 'csv'

# => define the business logic
class DBSkeletonClass
  attr_accessor :dbname, :username, :password, :con

  def initialize(dbname, usrname, pswrd)
    self.dbname = dbname
    self.username = usrname
    self.password = pswrd
  end

  # => method to connect to db
  def connect_db_method
    begin
      self.con = PG.connect :dbname => self.dbname, :user => self.username, :password => self.password
      return true
    rescue PG::Error => e
      puts e.message
      puts "Sorry Connection cannot be established"
      # => Forceful exit from the program
      Kernel.exit(0)
    end
  end

  # => method to establish connection
  public def establish_connection
    if connect_db_method
      puts "Connection Established"

      con.exec("SELECT id FROM \"schema_emp_QI\".tb_credential where username = \'#{username}\' \
                AND pass_word = \'#{password}\'") do |result|
        result.each do |row|
          return row.values_at('id')
        end
        if (result.length.zero?)
          puts "Sorry No data against this user available.Sign up first"
          Kernel.exit(0)
        end
      end
    end
  end

  # => public method to execute the query
  public def process_method(date_start, date_end)
    puts "For your information you are currently in #{Dir.pwd}"
    csv = CSV.open('Sample.csv', 'w')
    csv << ['Employee-ID', 'Employee-Name', 'Employee-Address', 'Employee-PhoneNo']
    id = establish_connection

    con.exec("SELECT * FROM \"schema_emp_QI\".tb_emp_master where emp_id = #{id[0].to_i}") do |result|
      result.each do |row|
        csv << row.values_at('emp_id', 'emp_name', 'emp_address', 'emp_contact_no')
      end
    end

    con.exec("SELECT * FROM  \"schema_emp_QI\".tb_emp_project where emp_id = #{id[0].to_i}
            AND updated_date >=\'#{date_start}\'::date AND updated_date <=\'#{date_end}\'::date") do |result|
      result.each do |row|
        csv << row.values_at('project_id', 'project_name', 'updated_date')
      end
    end
  end
end


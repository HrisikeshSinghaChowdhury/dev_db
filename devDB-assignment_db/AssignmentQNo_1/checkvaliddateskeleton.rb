# => import the date package
require 'date'

#a customized class skeleton
class CheckValidDateSkeleton
   # => method checks date validity
   def chkDate(dt_input)
      begin
         Date.parse(dt_input)
         true
      rescue Date::Error => e
         puts "#{dt_input} is not valid because #{e.message}.Program terminates here"
         Kernel.exit(0)
      ensure
         puts "--------------"
      end
   end
end

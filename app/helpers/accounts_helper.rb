module AccountsHelper
    require 'time'

    def date_fix(date)
        time = Time.parse(date)
        clean_date = time.strftime("%b %d %Y")
      end 
end

module EventsHelper
  
  def parse_datetime(hash)
    [1,2,3,4,5].map { |e| hash.delete("date(#{e}i)").to_i }
  end
  
end

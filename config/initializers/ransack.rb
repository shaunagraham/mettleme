Ransack.configure do |config|

  config.add_predicate 'spaces_match_anything',
  :arel_predicate => 'matches', # so we can use the SQL wildcard "%"
  # Format the incoming value: add the SQL wildcard character "%" to the beginning and the end of
  # the string, replace spaces by "%", and replace multiple occurrences of "%" by a single "%".
  :formatter => proc {|v| ("%"+v.gsub(" ", "%")+"%").squeeze("%")}

end
class String
    # Convert String to Hash 
    def to_hash(arr_sep=/\n+/, key_sep='=>', len = 1)
        # Split string by array seperator
        array = self.split(arr_sep)
        hash = {}
        
        array.each do |e|
            
            key_value = e.split(key_sep)
            key_value.each { |a| a.strip! if a.respond_to? :strip! }
            if key_value[0]
                if (key_value[0].length == len && key_value[1].length == len)
                    hash[key_value[0]] = key_value[1] 
                else
                    raise StandardError.new "Invalid Key/Value"
                end
            end
        end

        return hash
    end
end





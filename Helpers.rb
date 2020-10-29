# Add to Ruby's default String class
class String
    # Convert String to Hash 
    def to_hash(arr_sep=/\n+/, key_sep='=>')
        # Split string by array seperator
        array = self.split(arr_sep)
        hash = {}
        
        array.each do |e|
            key_value = e.split(key_sep)
            # trim separated strings
            key_value.each { |a| a.strip! if a.respond_to? :strip! }
            hash[key_value[0]] = key_value[1] if key_value[0]
        end
        
        return hash
    end
end

# Add to Ruby's default Hash class
class Hash 
    # delete keys from Hash
    def except(*keys)
        keys.each { |k| self.delete k }
        self
    end
end
class String
    def to_hash(arr_sep=/\n+/, key_sep='=>', len = 1)
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

# Check if variable is a string
def isString(str)
    #  Raise invalid string exception
    raise StandardError.new "Invalid String" if str.class != String
end

def batchJobs(str)
    begin
        isString(str)
    rescue StandardError => e
        puts "#{str} #{e.inspect}"
        return
    end

    jobs = ''

    return jobs if str.empty?

    begin
        jobs = jobSorter str.to_hash
    rescue StandardError => e
        puts "#{e.inspect}"
        return
    end

    jobs.join(', ')
end
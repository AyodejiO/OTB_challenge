def isString(str)
    raise "Invalid String" if str.class != String
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
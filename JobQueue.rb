class JobQueue
    # constructor
   def initialize(jobs_str)
        @jobs_str = jobs_str #set jobs in string
    end

    # Check if variable is a string
    def isString(str)
        #  Raise invalid string exception
        raise StandardError.new "Invalid String" if str.class != String
    end

    def batchJobs()
        begin
            isString(@jobs_str)
        rescue StandardError => e
            puts "#{@jobs_str} #{e.inspect}"
            return
        end
    
        jobs = ''
    
        return jobs if @jobs_str.empty?
    
        begin
            jobs = jobSorter @jobs_str.to_hash
        rescue StandardError => e
            puts "#{e.inspect}"
            return
        end
    
        jobs.join(', ')
    end
end
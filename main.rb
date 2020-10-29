require './Helpers.rb'

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

    # Sorts the hashed jobs and resolves dependencies
    def jobSorter batch
        # create sorted jobs array
        jobs = [] 
    
        # process each key/value in hash
        until batch.empty?
            # Select jobs with resolved dependencies
            cleared_jobs = batch.select {|key, value| ([*value]-jobs).empty? }.keys
            # Throw error if batch is non-empty and no job is resolved to avoid infinite loops
            raise StandardError.new "Unresolved job dependencies" if cleared_jobs.empty?
            # add resolved jobs to sorted jobs array
            jobs += cleared_jobs
            # remove resolved jobs from hash
            batch.except(*cleared_jobs)
            
            # break
        end

        # return sorted jobs
        return jobs
    end

    def batchJobs()
        # confirm that supplied jobs is in string format or throw exception
        begin
            isString(@jobs_str)
        rescue StandardError => e
            return "#{e.inspect}"
        end
    
        # create output message
        jobs = ''
    
        # return empty outout if job string is empty
        return jobs if @jobs_str.empty?
    
        # hash jobs and sort or catch exceptions that may arise
        begin
            jobs = jobSorter @jobs_str.to_hash
        rescue StandardError => e
            return "#{e.inspect}"
        end

        jobs.join(', ')
    end
end

# TESTS
cases = []

# Typical Example that should work
cases << JobQueue.new(%q(
    a =>
))

# Typical Example that should work
cases << JobQueue.new(%q(
    a =>
    b =>
    c =>
))

# Typical Example that should work
cases << JobQueue.new(%q(
    a =>
    b => c
    c =>
))

# Typical Example that should work
cases << JobQueue.new(%q(
    a =>
    b => c
    c => f
    d => a
    e => b
    f =>
))
    
# Job c depends on c (Unresolved Dependency)
cases << JobQueue.new(%q(
    a =>
    b =>
    c => c
))

# Example that should fail (Circular Dependency)
cases << JobQueue.new(%q(
    a =>
    b => c
    c => f
    d => a
    e =>
    f => b
))

# Number supplied
cases << JobQueue.new(0.45)

# Boolean supplied
cases << JobQueue.new(true)

cases << JobQueue.new('')

# Add more cases

cases.each_with_index { |v, i| puts "case #{i}...#{v.batchJobs()}" }

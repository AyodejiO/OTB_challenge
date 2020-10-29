# Typical Example that should work
case0 = JobQueue.new(%q(
    a =>
    b =>
    c =>
))
# Typical Example that should work
case1 = JobQueue.new(%q(
    a => b
    b => c
    f =>
    c =>
    g => h
    h =>
))
    
# Job f depends on F (Unresolved Dependency)
case2 = JobQueue.new(%q(
    a => b
    b => c
    f => f
    c =>
    g => h
    h =>
))

# Number supplied
case3 = JobQueue.new 0.45

# Boolean supplied
case4 = JobQueue.new true

# puts case0.batchJobs
# puts case1.batchJobs
# puts case2.batchJobs
# puts case3.batchJobs
# puts case4.batchJobs
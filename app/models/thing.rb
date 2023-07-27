class Thing < ActiveRecord::Base
  has_many :minions
end

# performance_development=# select pg_size_pretty(pg_relation_size('things'));
#  pg_size_pretty 
# ----------------
#  11 MB, so we are dealing with an 11 MB DB

# ================ Use select ====================

# Measure.run(gc: :disable) { Thing.all.load }
# {"2.7.0":{"gc":"disable","time":0.15,"gc_count":0,"memory":"23 MB"}}
# Loading all actually allocates about 23 MB, or double the memory

# Measure.run(gc: :disable) {Thing.all.select(:id, :col1, :col5).load}
# {"2.7.0":{"gc":"disable","time":0.07,"gc_count":0,"memory":"13 MB"}}

# ================ Use size ======================

# Measure.run(gc: :disable) { Thing.all.length } # load all records into memory, then calculate # of records
# {"2.7.0":{"gc":"disable","time":0.53,"gc_count":0,"memory":"61 MB"}}

# Measure.run(gc: :disable) { Thing.all.count } # will always go to the database
# {"2.7.0":{"gc":"disable","time":0.01,"gc_count":0,"memory":"0 MB"}}

# Measure.run(gc: :disable) { Thing.all.size }
# {"2.7.0":{"gc":"disable","time":0.01,"gc_count":0,"memory":"0 MB"}} # best of both worlds


# =================== Use any or none ===================================
# Measure.run(gc: :disable) { Thing.all.exists? } # always triggers a query even if records are in memory
# {"2.7.0":{"gc":"disable","time":0.01,"gc_count":0,"memory":"6 MB"}}

# Measure.run(gc: :disable) { Thing.all.present? } # will always load objects into memory
# {"2.7.0":{"gc":"disable","time":0.13,"gc_count":0,"memory":"45 MB"}}

# Measure.run(gc: :disable) { Thing.all.any? } # or none?, these are the best of both worlds
# {"2.7.0":{"gc":"disable","time":0.0,"gc_count":0,"memory":"0 MB"}}


# ==================== Use the DB ==========================
# Measure.run(gc: :disable) {
#   Thing.where(col0: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx").select do |thing|
#     thing.col2.starts_with?('x')
#   end.take(10)
# }

# {"2.7.0":{"gc":"disable","time":0.15,"gc_count":0,"memory":"41 MB"}}

# Measure.run(gc: :disable) {
#   Thing.where(col0: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
#     .where('col2 LIKE x%')
#     .limit(10)
# }
# {"2.7.0":{"gc":"disable","time":0.0,"gc_count":0,"memory":"0 MB"}}

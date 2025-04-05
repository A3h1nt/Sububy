module Stat
	def Stat.get
		uniq_subd = (Fileop.read "identified_host.txt").count
		live_subd = (Fileop.read "live_host.txt").count
		puts "Unique Subdomains: #{uniq_subd}"
		puts "Live Subdomains: #{live_subd}"
		puts "Screenshot Taken: #{$ss_counter}"
	end
end

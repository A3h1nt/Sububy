module Fileop

	def Fileop.write(filename,data_array)
		fh = File.new "#{$output_dir}/#{filename}","w"
		data_array.each {|d| fh.write("#{d}\n")}
		fh.close
	end

	def Fileop.writeS(filename,data_string)
		fh = File.new "#{$output_dir}/#{filename}","w"
		fh.write(data_string)
		fh.close
	end

	def Fileop.readS(filename)
		fh = File.new "#{$output_dir}/#{filename}","r"
		data = fh.readlines
		fh.close
		return data
	end

	def Fileop.readw(filename)
		data = []
		fh = File.new "#{filename}","r"
		fh.readlines.each { |d| data << d.chomp }
		fh.close
		return data
	end

	def Fileop.read(filename)
		data = []
		fh = File.new "#{$output_dir}/#{filename}","r"
		fh.readlines.each { |d| data << d.chomp }
		fh.close
		return data
	end

	def Fileop.append(filename,data_array)
		fh = File.new "#{$output_dir}/#{filename}","a"
		data_array.each {|d| fh.write("#{d}\n")}
		fh.close
	end

	def Fileop.fcheck(filename)
		if(!File.exist?(filename))
			$error << "Error : Wordlist #{filename} does not exist."
 		end
	end

	def Fileop.dircheck(dirname)
		Dir.mkdir dirname if(!Dir.exist?(dirname))
		$output_dir = dirname
	end
end


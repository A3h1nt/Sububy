module Sshot	
	$ss_counter = 0
	def Sshot.http(host_file)
		Dir.mkdir "#{$output_dir}/http"
		data = Fileop.read(host_file)
		begin
			data.each do |d|
				opt = Selenium::WebDriver::Options.chrome(args: ['--headless=new','--ignore-certificate-error'])
				driver = Selenium::WebDriver.for :chrome, options: opt
				driver.get "http://#{d.chomp}/"
				sleep 2
				driver.save_screenshot("#{$output_dir}/http/#{d.chomp}.png")
				$ss_counter += 1
				driver.close
		rescue => e
				puts "#{d.chomp} - Some error occured : #{e}"
			end	
		end
	end

	def Sshot.https(host_file)
			Dir.mkdir "#{$output_dir}/https"
			data = Fileop.read(host_file)
			begin
				data.each do |d|
					opt = Selenium::WebDriver::Options.chrome(args: ['--headless=new','--ignore-certificate-error'])
					driver = Selenium::WebDriver.for :chrome, options: opt
					driver.get "https://#{d.chomp}/"
					sleep 2
					driver.save_screenshot("#{$output_dir}/https/#{d.chomp}.png")
					$ss_counter += 1
					driver.close
			rescue => e
					puts "#{d.chomp} - Some error occured"
				end	
			end
		end
end

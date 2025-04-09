#!/usr/bin/ruby

# Important Modules
require 'http'
require 'json'
require 'socket'
require 'selenium-webdriver'
require 'colorize'

class Sububy

	# Global variables to work with
	$dnsdumpster_api_key =	ENV['dnsd_api_key'] 
	$virustotal_api_key = ENV['vt_api_key']
	$temp_list = [] 
	$live_host = []
	$csp_list = []
	$subd = []
	$error = []
	$output_dir = Dir.pwd
	
	# Importing modules
	require_relative 'modules/cert.rb'
	include Cert
	require_relative 'modules/brute.rb'
	include Brute
	require_relative 'modules/dnsdumpster.rb'
	include Dnsd
	require_relative 'modules/virustotal.rb'
	include Vtotal
	require_relative 'modules/csp.rb'
	include Csp
	require_relative 'modules/sort.rb'
	include Sort
	require_relative 'modules/live.rb'
	include Live
	require_relative 'modules/file.rb'
	include Fileop
	require_relative 'modules/stat.rb'
	include Stat
	require_relative 'modules/sshot.rb'
	include Sshot
	require_relative 'modules/info.rb'
	include Info
	require_relative 'modules/webarchive.rb'
	include WebArch

	def output(operation)
		case operation
			when "cert"
				puts "[-] Cert Module Initiated ".colorize(:yellow)
				Cert.get($domain)
				puts "[+] "+"Identified Subdomains".colorize(:blue)+":"+"#{Fileop.read('cert.txt').count}".colorize(:green)
				
			when "brute"
				puts "[-] Brute Module Initiated ".colorize(:yellow)
				Brute.bruteforce($domain,$wordlist)
				puts "[+] "+"Identified Subdomains".colorize(:blue)+":"+"#{Fileop.read('brute.txt').count}".colorize(:green)

			when "dnsd"
				puts "[-] DnsDumpster Module Initiated ".colorize(:yellow)
				Dnsd.getsub($domain)
				puts "[+] "+"Identified Subdomains".colorize(:blue)+":"+"#{Fileop.read('dnsd.txt').count}".colorize(:green)

			when "vtotal"
				puts "[-] Virustotal Module Initiated ".colorize(:yellow)
				Vtotal.getsub($domain)
				puts "[+] "+"Identified Subdomains".colorize(:blue)+":"+"#{Fileop.read('vtotal.txt').count}".colorize(:green)

			when "sort"
				Sort.domain($domain,'temp.txt')

			when "live"
				puts "[-] Finding out live subdomains ".colorize(:yellow)
				Live.get('identified_host.txt')
				puts "[+] "+"Total live subdomains".colorize(:blue)+":"+"#{Fileop.read('live_host.txt').count}".colorize(:green)

			when "csp"
				puts "[-] Getting subdomains from CSP of live hosts".colorize(:yellow)
				Csp.cspsub('live_host.txt',$cn)
				puts "[+] "+"Identified Subdomains".colorize(:blue)+":"+"#{Fileop.read('csp.txt').count}".colorize(:green)

			when "csp.sort"
				puts "[-] Sorting out ".colorize(:yellow)
				Sort.sortf($domain,'csp.txt')

			when "csp.live"
				Live.get('sortf.txt')
				puts "[+] Enumeration done, initiating screenshot module. ".colorize(:blue)

			when "http.shot"
				puts "[-] Taking HTTP screenshots ".colorize(:yellow)
				Sshot.http('live_host.txt')
				puts "[+] Done ".colorize(:green)

			when "https.shot"
				puts "[-] Taking HTTPs screenshots ".colorize(:yellow)
				Sshot.https('live_host.txt')
				puts "[+] Done ".colorize(:green)

			when "webarch.get"
				puts "[-] Fetching Data From WebArchive ".colorize(:yellow)
				WebArch.get($domain)
				puts "[+] "+"Identified Subdomains".colorize(:blue)+":"+"#{Fileop.read('webarchive.txt').count}".colorize(:green)	
		end
	end

	def start
		puts "\n\n"
		puts  " ░▒▓███████▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓███████▓▒░  ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓███████▓▒░  ░▒▓█▓▒  ▒▓█▓▒░ "
		puts  " ░▒▓█▓▒░       ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ "
		puts  " ░▒▓█▓▒░       ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ "
		puts  " ░▒▓██████▓▒░  ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓███████▓▒░  ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓███████▓▒░   ░▒▓██████▓▒░  "
		puts  "       ░▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░    ░▒▓█▓▒░     "
		puts  "       ░▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░    ░▒▓█▓▒░     "
		puts  " ░▒▓██████▓▒░   ░▒▓██████▓▒░  ░▒▓███████▓▒░   ░▒▓██████▓▒░  ░▒▓███████▓▒░     ░▒▓█▓▒░     "+"Author:"+"@A3h1nt".colorize(:blue)
		puts  "\n\n"

		output "cert"
		output "webarch.get"
		output "brute"
		output "dnsd"
		output "vtotal"
		output "sort"
		output "live"
		output "csp"
		output "csp.sort"
		output "csp.live"
		output "http.shot"
		output "https.shot"
		Stat.get		
	end

	def initialize
		if $dnsdumpster_api_key.nil? | $virustotal_api_key.nil?
			puts 'Configure API keys in dnsd_api_key & vt_api_key environment variables.'
			return 1
		end
		recvd_args = ARGV
		if recvd_args.count != 4
			puts ""
			puts "	Syntax : ruby sububy.rb <domain> <cn> <wordlist> <output-dir>"
			puts ""
			puts "	<domain>      : The target domain"
			puts "	<cn> 	      : A common name for target"
			puts "	<wordlist>    : Wordlist for bruteforcing subdomains"
			puts "	<output-dir>  : Directory to output to"
			puts ""
		else
			$domain = recvd_args[0]
			$cn = recvd_args[1]
			$wordlist = recvd_args[2]
			$dir = recvd_args[3]
			Fileop.fcheck($wordlist)
			Fileop.dircheck($dir)
			if($error.empty?)
				start
			else
				puts $error
			end
		end
	end
	
end

obj = Sububy.new

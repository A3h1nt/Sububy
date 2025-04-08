# Sububy

Sububy is a one stop subdomain enumeration suite written in ruby, it focuses on accuracy and quality with the flexibility of accessing some modules individually without having to stick with the tool execution flow, allowing you to integrate it with your work flow.

![alt text](/Image/sub.png)

Sububy comes with nine modules in total, out of these 9, five modules are for enumeration and the rest performs post enumeration operation.

| Category             | Module | Description                                                                                             |
| -------------------- | ------ | ------------------------------------------------------------------------------------------------------- |
| **Enumeration**      | Cert   | Retrieves subdomains from certificate transparency logs.                                                |
|                      | Brute  | Bruteforce subdomains using the provided wordlist.                                                      |
|                      | Dnsd   | Fetches subdomains from DnsDumpster (API key required : Free).                                          |
|                      | Vtotal | Fetches subdomains from VirusTotal (API key required : Free).                                           |
|                      | Csp    | Fetches subdomains from the CSP of identified live domains.                                             |
| **Post Enumeration** | Sort   | Sorts the identified subdomains for duplicates as well as host not belonging to the target domain name. |
|                      | Live   | Identifies the subdomain with active running webserver.                                                 |
|                      | Sshot  | Takes screenshot using HTTP and HTTPs protocol.                                                         |
|                      | Info   | Allows you to retrieve basic HTTP information like response status code and response headers.           |
## Installation

1. Install the tool and gems

```bash
git clone https://github.com/A3h1nt/Sububy.git
cd Sububy
bundle install 
```

2. Configure API keys in `Sububy.rb` , you can get them using the following URL

- [DnsDumpster](https://dnsdumpster.com/developer/)
- [VirusTotal](https://www.virustotal.com/gui/)

3. Run it

```rb
ruby Sububy.rb <domain> <cn> <wordlist> <output-dir>
```
![alt text](/Image/example.png)

## Accessing Individual Modules

Sububy modules are written in a way that allows you to access them individually, without having to run the entire tool again and again. Before you can start using the individual modules, you'll need to load the file in your ruby shell. Launch the ruby shell by typing `irb` in your terminal and load the sububy file.

```rb
irb(main):002:0> require_relative 'Sububy.rb'
irb(main):002:0> # Set the output directory
irb(main):002:0> $output_dir = '/path/to/output_dir'
```
### 1. Enumeration Module

*Want to enumerate subdomains only?*

```rb
Cert.get(domain) #-> cert.txt
Brute.bruteforce(domain,wordlist) #-> brute.txt
Dnsd.getsub(domain) #-> dnsd.txt
Vtotal.getsub(domain) #-> vtotal.txt
```
### 2. Sorting Module

*Already have a list of subdomains and need some sorting?*

```rb
Sort.domain(domain,file) #-> returns identified_host.txt with domain name mentioned in subdomain
Sort.uniq(file1,file2) #-> combine and returns unique subdomains 
```
### 3. Live Module

*Already have a list of subdomains and need to find out the live ones?*

```rb
Live.get(host_file) #-> returns live_host.txt with list of alive host
```
### 4. Sshot Module

*Already have a list of subdomains and want to take screenshot?*

```rb
Sshot.http(host_file) #-> returns http screenshots in http/
Sshot.https(host_file) #-> returns https screenshoots in https/
```

### 5. Info Module

*Want more information on your subdomains?*

```rb
Info.info "hosts.txt" #-> Initiates the info module, you need to run this before you can use other methods
Info.headers "hostname" #-> Returns response headers for a particular host
Info.headersall #-> Returns response headers for all hosts specified in the file
Info.status "hostname" #-> Returns response status code for a particular host
Info.statusall #-> Returns response status for all hosts specified in the file
Info.title "hostname" #-> Returns webpage title for a particular host
Info.titleall #-> Returns webpage title for all hosts specified in the file
Info.comments #-> Writes scaraped comments to file
Info.links #-> Writes scraped links to file
```

### Variables

Sububy uses some global variables to store data, these variables can be accessed directly as well.

```rb
$dnsdumpster_api_key  # API key for dnsdumpster
$virustotal_api_key   # API key for virustotal
$live_host            # Array of live host
$csp_list = []        # Array of host identified from CSP
$output_dir           # Path to output directory
```

## How To Contribute ?

- Add new features
- Improve code quality
- Resolve errors

Ping me at : a3h1nt@gmail.com








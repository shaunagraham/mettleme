# Make Paperclip use subdomain URLs
# See http://www.conandalton.net/2011/02/paperclip-s3-and-european-buckets.html
#
# Note that there should be no trailing slash after the domain name;
# the :path option in has_attached_file should contain that.
#
#Paperclip.interpolates(:s3_path_url) do |a, s| # attachment, style  
#  "#{a.s3_protocol}://#{a.bucket_name}.s3-us-west-1.amazonaws.com#{a.path(s)}"  
#end
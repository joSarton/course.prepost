# Rebuild documentation when modifying files
guard :shell do
    watch(/(.*).adoc/) do |a|
        time = Time.new
        timestring = time.strftime("%H:%M:%S")
        puts "#{timestring} - INFO - Got change for: #{a[0]}"
        `npx antora --cache-dir=/workspaces/CSMI-PrePost/public/.cache/antora /workspaces/CSMI-PrePost/site-dev.yml`
    end
end

# # Refresh browser when folder with HTML files changes
# guard :livereload do
#     watch(/(.*).html/)
# end

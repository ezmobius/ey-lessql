execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end

require_recipe 'tokyo'
require_recipe 'redis'
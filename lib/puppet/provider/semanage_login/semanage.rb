require 'open3'

Puppet::Type.type(:semanage_login).provide(:semanage) do
  desc "semanage"
  
  commands :semanage => "semanage"
  
  def create
    semanage "login", "-a", "-S", resource[:policy], "-s", resource[:seluser], "-r", resource[:mlsrange], resource[:user]
  end
  
  def destroy
    semanage "login", "-d", resource[:user]
  end
  
  def exists?
    users = []
    Open3.popen3("semanage login -l -n") { |stdin, stdout, stderr| 
      users = stdout.readlines.collect { |line| line.strip.squeeze(" ").split[0] }
    }
    users.include? resource[:user]
  end
  
  def seluser
    seluser = nil
    Open3.popen3("semanage login -l -n") { |stdin, stdout, stderr|
      seluser = stdout.readlines.collect { |line| line.strip.squeeze(" ").split }.reject { |foo| foo[0] != resource[:user] }[1]
    }
    seluser
  end
  
  def seluser=(value)
    semanage "login", "-m", "-s", value, resource[:user] 
  end
end
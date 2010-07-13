Puppet::Type.newtype(:semanage_login) do
  @desc = "foo"
  
  ensurable
  
  newparam(:user) do
    desc "The user name"
    isnamevar
  end
  
  newparam(:mlsrange) do
    desc "some description"
    defaultto "s0-s0:c0.c1023"
  end
  
  newparam(:policy) do
    desc "SELinux policy"
    defaultto "targetted"
  end
  
  newparam(:seluser) do
    desc "something"
    defaultto "__default__"
  end
end
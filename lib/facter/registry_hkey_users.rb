Facter.add(:registry_hkey_users) do
  confine :kernel => :windows
  setcode do
    require 'win32/registry'
    Win32::Registry::HKEY_USERS.keys.select{|k| k !~ /_Classes$/}.join(',')
  end
end

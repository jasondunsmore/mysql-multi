#
# Cookbook Name:: mysql-multi
# Recipe:: _find_master
#
# Copyright 2014, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
end
if node['mysql-multi']['master'].nil? && !Chef::Config[:solo]
  master = search('node', 'tags:mysql_master'\
                  " AND chef_environment:#{node.chef_environment}")

  Chef::Log.warn('Multiple servers tagged as master found!') if master.count > 1

  node.set['mysql-multi']['master'] = best_ip_for(master.first)
end

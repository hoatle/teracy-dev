#
# Author:: Hoat Le <hoatle@teracy.com>
# Cookbook Name:: teracy-dev
# Recipe:: docker
#
# Copyright 2013 - current, Teracy, Inc.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:

#     1. Redistributions of source code must retain the above copyright notice,
#        this list of conditions and the following disclaimer.

#     2. Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.

#     3. Neither the name of Teracy, Inc. nor the names of its contributors may be used
#        to endorse or promote products derived from this software without
#        specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

docker_conf = node['teracy-dev']['docker']

def get_docker_compose_autocomplete_url
    release = node['docker_compose']['release']
    "https://raw.githubusercontent.com/docker/compose/#{release}/contrib/completion/bash/docker-compose"
end

if docker_conf['enabled'] == true

    installation_conf = docker_conf['installation']

    act = :create
    if installation_conf['action'] == 'delete'
        act = :delete 
    end

    docker_installation 'default' do
        repo installation_conf['repo']
        action act
    end
    group 'docker' do
        action :modify
        members installation_conf['members']
        append true
    end

    if node['teracy-dev']['docker_compose']['enabled'] == true
        include_recipe 'docker_compose::installation'

        # install docker-compose auto complete
        autocomplete_url = get_docker_compose_autocomplete_url

        execute 'install docker-compose autocomplete' do
            action :run
            command "curl -L #{autocomplete_url} > /etc/bash_completion.d/docker-compose"
            creates '/etc/bash_completion.d/docker-compose'
            user 'root'
            group 'docker'
        end
    end
end


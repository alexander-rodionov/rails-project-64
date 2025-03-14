#!/bin/bash

# bin/rails d model Category name:string
# bin/rails d model User email:string password:string
# bin/rails d model Post title:string categtory:references body:text creator:references status:string
# bin/rails d model PostLike post:references creator:references
# bin/rails d model PostComment parent_id:string:index creator:references content:text

# bin/rails d controller Likes create destroy
# bin/rails d controller Comments create
# bin/rails d controller Posts index show new create
# bin/rails d controller User new create login logout

bin/rails g model Category name:string
bin/rails g model User email:string password:string
bin/rails g model Post title:string categtory:references body:text creator:references status:string
bin/rails g model PostLike post:references creator:references
bin/rails g model PostComment parent_id:string:index creator:references content:text

bin/rails g controller Likes create destroy
bin/rails g controller Comments create
bin/rails g controller Posts index show new create
bin/rails g controller User new create login logout


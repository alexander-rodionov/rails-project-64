Метод parse_post лушче назвать set_post и вынести под private

Экшн toggle нам вообще не нужен, мы должны на уровне view определять что мы хотим сделать поставить лайк или убрать его. Например:

      - if post.liked_by_user(current_user)
        = link_to '',
            post_like_path(post.id, post.like_by_user(current_user)),
            class: 'bi bi-hand-thumbs-up-fill',
            data: { turbo_method: :delete }
      - else
        = link_to '',
            post_likes_path(post.id),
            class: 'bi bi-hand-thumbs-up',
            data: { turbo_method: :post }
Давай чуть-чуть разгрузим контроллер от like и unlike. Пойдем по стандартному RoR контроллеров пути, например:

def create
authenticate_user!

@post = Post.find(params[:post_id])
@post.likes.find_or_create_by(user: current_user)

redirect_to @post
end
def destroy authenticate_user!

@post = Post.find(params[:post_id]) @post.like_by_user(current_user)&.destroy

redirect_to @post end


4. Необходимо убрать лишние комментарии кода, например [тут](https://github.com/alexander-rodionov/rails-project-64/blob/96483ec0f4538a69ae1c603fbb8556d2dd2b6068/app/views/posts/_post_form.html.slim#L1-L9), [тут](https://github.com/alexander-rodionov/rails-project-64/blob/92e4e37fe4387fa9d2b635fb53f1a682a42ed4c2/test/controllers/likes_controller_test.rb#L13), [тут](https://github.com/alexander-rodionov/rails-project-64/blob/a92af7224a2255730f596e6133af47c470c589d6/test/controllers/posts_controller_test.rb#L84-L92) и [тут](https://github.com/alexander-rodionov/rails-project-64/blob/6f4543793910b4899de36f74a893ee39c041fd91/test/controllers/user_controller_test.rb). В Ruby и Ruby on Rails лучшие комментарии - это красивый код, который должен сам описывать, что он делает с помощью названий методов, переменных и т.д.

Жду правки!
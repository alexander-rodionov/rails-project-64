Привет!) Давай посмотрим, что удалось поправить, а что еще мы можем сделать лучше:

+ 1) Падает сборка CI, давай починим, судя по ошибке нам нужно обновить Brakeman. Ну и еще важный вопрос, а для чего он нам? Если бы мы использовали какой-нибудь pry для удобства дебага, я бы понял, а тут прям очень сомнительно


+ 2) Данный метод не имеет смысла, так как мы можем запрашивать значения через связи,

post.creator_email

и

post.creator&.email

Никакой разницы нет, только увеличение объема модели post. Давай уберем этот метод

+ 3) Мы можем тут явно не указывать class_name User, rails должен найти эту модель и так

+ 4) Код в моделях стал чище и теперь лучше визуально воспринимается, но зачем комментарии?)) Например тут. Их необходимо убрать, мы и так должны воспринимать и уметь отличать валидации от скоупов

5) А вот тут стоит добавить пропуск строки между объявлением devise и связью has_many. На первый взгляд это может показаться какой-то дичью, но это не так. Каждый пропуск строки важен и единый стиль - это тоже важно, такие штуки очень быстро помогают качественно воспринимать свой же код, который был написан несколько месяцев назад, да и коллеги скажут спасибо

6) Необходимо избавиться от контроллеров users, которые нам не нужны в функционале и лежат мертвым грузом (про роуты тоже важно помнить, и почистить, если они есть)

7) В CommentsController происходит что-то объемное и непонятное, надо улучшать качество кода.

начнем с пропусков строк, необходимо отделять пропуском строки экшены create от before фильтров(before_action)
зачем нам лишняя логика в экшене по рендеру неавторизованного пользователя? Достаточно authenticate_user! от devise, который и так кидает нотификацию, метод render_unauthorized лишний, его необходимо убрать из ApplicationController
для permitted_params нам необходимо добавить отдельный private метод в контроллере: def comment_params params.require(:post_comment).permit(:parent_id, :content) end
Далее

post = Post.find(params.require(:post_id))
исправляем на

@post = Post.find(params[:post_id])
require тут не нужен, а переменна инстанса @post поможет использовать пост во вью или рендере

Далее

parent = values[:parent_id].blank? ? nil : PostComment.find(values[:parent_id])
@comment = PostComment.create(parent: parent, post: post, user: current_user, content: values[:content])
исправляем на

@comment = current_user.comments.build(comment_params)
@comment.post = @post
Далее

Обработку ошибок мы тоже можем сделать красивее, например вместо

    if @comment.new_record?
      error_text = @comment.errors.map do |v|
        "#{PostComment.human_attribute_name(v.attribute)} #{@comment.errors[v.attribute.to_sym].join(', ')}"
      end.join('\n')
      redirect_to post_path(post.id), id: post.id, alert: error_text
    else
      redirect_to post_path(post.id), success: t('messages.comment_created')
    end
вот так

    if @comment.save
      flash[:success] = t('.success')
    else
      flash[:error] = @comment.errors.full_messages.join('. ')
    end

    redirect_to @post
Таким образом код стал намного чище, и воспринимается он намного лучше. Рельсы - это благо и проклятье из-за одних и тех же штук, например рельсовой магии по типу:

   @comment = current_user.comments.build(comment_params)
И ее нужно изучать с помощью лекций курса и статей, также сейчас очень удобно спрашивать про оптимизацию, но обязательно с объяснением и разбором у нейронок, а иначе смысла в этом нет. Нам нужно учиться и прокачиваться, уверен, что все получится

Жду правки! Желаю успеха!

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Комментарии к посту</title>
    <style>
        body {
            background: linear-gradient(#d9a7c7, #fffcdc);
            color: #000000;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #000000;
            margin-bottom: 20px;
        }

        img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        h3 {
            color: #000000;
            margin-top: 30px;
            margin-bottom: 10px;
        }

        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            width: 100%;
            max-width: 600px;
        }

        li {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 15px;
            margin: 10px 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            min-width: 650px;
        }

        form {
            margin-top: 20px;
            max-width: 600px;
            width: 100%;
            background-color: #F9F9F9;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin: 10px 0 5px;
        }

        textarea, input[type="email"] {
            width: 95%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        button {
            background-color: #7a0350;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #8c2c68;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            color: #7a0350;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<h2>${post.content}</h2>

<#if post.imagePath?has_content>
    <img src="/uploads/${post.imagePath}" alt="Изображение поста">
<#else>
    <p>Изображение недоступно</p>
</#if>

<p>Создано: ${post.createdDate?string("dd-MM-yyyy HH:mm")}</p>

<h3>Комментарии</h3>
<#if post.comments?has_content>
    <ul>
        <#list post.comments as comment>
            <li>
                <p>${comment.text}</p>
                <p>Создано: ${comment.created?string("dd-MM-yyyy HH:mm")}</p>
                <form action="/posts/comments/delete" method="post">
                    <#if _csrf??>
                        <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                               value="${(_csrf.token)!'csrf-token'}"/>
                    </#if>
                    <input type="hidden" name="commentId" value="${comment.id}" />
                    <input type="hidden" name="postId" value="${post.id}" />
                    <button type="submit">Удалить комментарий</button>
                </form>
            </li>
        </#list>
    </ul>
<#else>
    <p>Комментариев пока нет.</p>
</#if>

<h3>Добавить комментарий</h3>
<form action="/posts/${post.id}/comments" method="post">
    <#if _csrf??>
        <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
               value="${(_csrf.token)!'csrf-token'}"/>
    </#if>
    <label for="content">Контент:</label>
    <textarea name="content" required></textarea>
<#--    <label for="email">Email:</label>-->
<#--    <input type="email" name="email" required>-->
    <button type="submit">Добавить комментарий</button>
</form>

<a href="/posts">Назад</a>
</body>
</html>

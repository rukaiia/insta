
<#import '../layout.ftlh' as layout>

<@layout.layout ; spring>
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Мои обьявления</title>
        <style>
            body {
                background-color: #f0f0f0;
                color: #333;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            h1 {
                color: #2f4f4f;
                text-align: center;
                margin-top: 30px;
            }
            .post-list {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
                padding: 20px;
                margin: 0;
            }
            .post-card {
                background-color: #fff;
                border: 1px solid #dcdcdc;
                border-radius: 10px;
                width: 300px;
                padding: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            .post-card img {
                max-width: 100%;
                border-radius: 8px;
                margin-bottom: 10px;
            }
            .post-card h2 {
                color: #2f4f4f;
                font-size: 18px;
                margin-bottom: 10px;
            }
            .post-card p {
                color: #555;
                margin-bottom: 5px;
            }
            .post-card button {
                background-color: #2f4f4f;
                color: #fff;
                border: none;
                border-radius: 5px;
                padding: 10px 15px;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 10px;
            }
            .post-card button:hover {
                background-color: #1e3932;
            }
            .form-container {
                background-color: #fff;
                border: 1px solid #dcdcdc;
                border-radius: 10px;
                padding: 20px;
                margin: 20px auto;
                width: 90%;
                max-width: 600px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .form-container label,
            .form-container textarea,
            .form-container input[type="file"] {
                width: 100%;
                display: block;
                margin-bottom: 10px;
            }
            .form-container textarea {
                height: 100px;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #dcdcdc;
                resize: vertical;
            }
            .form-container button {
                width: 100%;
                background-color: #2f4f4f;
                color: #fff;
                border: none;
                border-radius: 5px;
                padding: 10px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .form-container button:hover {
                background-color: #1e3932;
            }
            .back-link {
                display: block;
                text-align: center;
                color: #2f4f4f;
                margin: 20px 0;
                text-decoration: none;
            }
            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
    <h1>Мои обьявления</h1>

    <#if news?has_content>
        <div class="post-list">
            <#list news as post>
                <div class="post-card">
                    <#if post.imagePath?has_content>
                        <img src="/uploads/${post.imagePath}" alt="Post Image">
                    <#else>
                        <p>Изображение недоступно</p>
                    </#if>
                    <h2>${post.content}</h2>

                    <p>Создано: ${post.createdDate?string("dd-MM-yyyy HH:mm")}</p>

                    <form action="/news/delete" method="post">
                        <#if _csrf??>
                            <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                   value="${(_csrf.token)!'csrf-token'}"/>
                        </#if>
                        <input type="hidden" name="id" value="${post.id}" />
                        <button type="submit">Удалить обьявление</button>
                    </form>
                </div>
            </#list>
        </div>
    <#else>
        <p>У вас пока нет постов.</p>
    </#if>

    <div class="form-container">
        <form action="/news/create" method="post" enctype="multipart/form-data">
            <#if _csrf??>
                <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                       value="${(_csrf.token)!'csrf-token'}"/>
            </#if>
            <label for="content">Обьявление:</label>
            <textarea name="content" required></textarea>
            <label for="image">Выберите изображение:</label>
            <input type="file" name="image" accept="image/*">
            <button type="submit">Добавить обьявление</button>
        </form>
    </div>

    <a href="/news" class="back-link">Назад ко всем обьявлениям</a>
    </body>
    </html>
</@layout.layout>

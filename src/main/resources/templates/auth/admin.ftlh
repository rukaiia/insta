
<#import '../layout.ftlh' as layout>
<@layout.layout; spring>
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Все Жалобы</title>
        <style>
            body {
                background: linear-gradient(#d9a7c7, #fffcdc);
                color: #333333;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }


            .post-container {
                margin-top: 80px;
                display: flex;
                flex-wrap: wrap;
                column-gap: 40px;
                row-gap: 60px;
                justify-content: center;
                max-width: 1200px;
                width: 100%;
            }
            .post-card {
                background-color: #f9f9f9;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 20px;
                width: 40%;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                transition: box-shadow 0.3s ease;
                text-align: center;
            }
            .post-card:hover {
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }

            h2 {
                color: #000000;
                font-size: 1.5em;
                margin: 0 0 10px 0;
            }
            .description {
                font-size: 1em;
                color: #555555;
                margin: 10px 0;
            }
            .district {
                font-size: 2em;
                color: #121212;
                margin: 10px 0;
            }

            img {
                max-width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 8px;
                margin: 15px 0;
            }

            button {
                padding: 8px 13px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s ease;
                color: white;
            }
            .accept-btn {
                background-color: #215629;
                margin-right: 10px;
            }
            .reject-btn {
                background-color: #790612;
            }
            .selected {
                background-color: #6c757d;
                cursor: default;
            }

            a {
                color: rgba(255, 0, 89, 0.33);
                font-weight: bold;
                text-decoration: none;
                display: inline-block;
                margin-top: 10px;
            }
            p {
                margin-top: 10px;
            }
            a:hover {
                text-decoration: underline;
            }
            .pagination a {
    margin: 0 5px;
    padding: 5px 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    text-decoration: none;
    color: #333;
}

.pagination span {
    margin: 0 5px;
    padding: 5px 10px;
    background-color: #e0e0e0;
    border-radius: 5px;
}
  h3{
      font-size: 1em;
      margin-bottom: 40px;
      text-align: center;

}
        </style>
    </head>
    <body>
    <h3>Aдминистрация</h3>
    <#if posts?has_content>
        <div class="post-container">
            <#list posts as post>
                <div class="post-card">
                    <h2>${post.user.email}</h2>
                    <#if post.imagePath?has_content>
                        <img src="/uploads/${post.imagePath}" alt="Post Image">
                    <#else>
                        <p>Изображение недоступно</p>
                    </#if>

                    <p class="district">${post.user.district}</p>
                    <p class="description">${post.content}</p>

                    <div class="post-actions">
                        <form action="/posts/${post.id}/accept" method="post" style="display: inline;">
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                       value="${(_csrf.token)!'csrf-token'}"/>
                            </#if>
                            <button type="submit" id="accept-${post.id}" class="accept-btn"
                                    onclick="disableButtons(${post.id})">Принять</button>
                        </form>

                        <form action="/posts/${post.id}/reject" method="post" style="display: inline;">
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                       value="${(_csrf.token)!'csrf-token'}"/>
                            </#if>
                            <button type="submit" id="reject-${post.id}" class="reject-btn"
                                    onclick="disableButtons(${post.id})">Отклонить</button>
                        </form>

                        <p id="like-count">${post.likeCounts} поддержки</p>
                        <a href="/posts/${post.user.id}/posts">Жалобы пользователя</a>
                    </div>
                </div>
            </#list>
        </div>
</#if>
       <#if (currentPage?? && totalPages?? && pageSize??) >
    <div class="pagination">
        <#if (currentPage > 0)>
            <a href="?page=${currentPage - 1}&size=${pageSize}">Предыдущая</a>
        </#if>

        <#list 0..(totalPages - 1) as i>
            <#if i == currentPage>
                <span>${i + 1}</span>
            <#else>
                <a href="?page=${i}&size=${pageSize}">${i + 1}</a>
            </#if>
        </#list>

        <#if currentPage < (totalPages - 1)>
            <a href="?page=${currentPage + 1}&size=${pageSize}">Следующая</a>
        </#if>
        </div>
    <#else>
        <p>Нет жалоб для отображения.</p>
    </#if>
    </body>
    <script>
        function disableButtons(postId) {
            var acceptBtn = document.getElementById('accept-' + postId);
            var rejectBtn = document.getElementById('reject-' + postId);

            acceptBtn.classList.add('selected');
            rejectBtn.classList.add('selected');
            acceptBtn.disabled = true;
            rejectBtn.disabled = true;
        }
    </script>
</html>
</@layout.layout>

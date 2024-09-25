<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить пост</title>
</head>
<body>
<h1>Добавить пост</h1>
<form action="/posts/create" method="POST">
    <#if _csrf??>
        <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
               value="${(_csrf.token)!'--no-token--'}"/>
    </#if>
    <label for="content">Содержимое поста:</label><br>
    <textarea id="content" name="content" rows="4" cols="50" required></textarea><br>
    <button type="submit">Добавить пост</button>
</form>

<#if error??>
    <div style="color: red;">${error}</div>
</#if>
</body>
</html>




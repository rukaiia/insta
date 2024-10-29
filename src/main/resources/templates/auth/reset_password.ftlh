<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <title>Document</title>
    <style>
        body {
            background: linear-gradient(#d9a7c7, #fffcdc);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 150px;
            color: #333;
            font-family: Arial, sans-serif;
        }

        form {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 100%;
            min-width: 400px;
            padding: 60px 60px 60px 30px;
            text-align: left;
        }

        .card h2 {
            font-size: 24px;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            font-size: 16px;
            color: #333;
            border: 1px solid #B06AB3;
            border-radius: 5px;
            background-color: #ffffff;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: #000000;
            background-color: rgba(255, 255, 255, 0.95);
        }

        .btn-primary {
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            width: 100%;
            margin-top: 20px;

        }

        .btn-primary {
            background-color: #7a0350;
            color: #ffffff;
            margin-left: 15px;
        }

        .btn-primary:hover {
            background-color: #8c2c68;
            transform: scale(1.05);
        }

        .text-danger {
            color: red;
        }
    </style>
</head>

<body>

<div class="py-5 h-100">
    <div class="row d-flex align-items-center justify-content-center h-100">
        <div class="col-md-7 col-lg-5 col-xl-5">
            <form action="/auth/reset_password" method="post">
                <#if _csrf??>
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                           value="${(_csrf.token)!'--no-token--'}"/>
                </#if>
                <div class="text-center">
                    <h2>Сброс пароля</h2>
                    <#if error??>
                        <b class="text-danger mt-3">${error}</b>
                    </#if>
                </div>
                <input type="hidden" name="token" value="${token!}">
                <input type="password" name="password" class="form-control m-3"
                       placeholder="Введите новый пароль" required autofocus/>
                <p class="text-center">
                    <button type="submit" class="btn btn-primary mt-3">Изменить пароль</button>
                </p>
            </form>
        </div>
    </div>
</div>
</body>

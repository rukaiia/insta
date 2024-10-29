
<#import '../layout.ftlh' as layout>

<@layout.layout ; spring>
    <style>
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            background: linear-gradient(#d9a7c7, #fffcdc);
            font-family: Arial, sans-serif;
            text-align: center;
        }

        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            width: 100%;
            max-width: 600px;
            padding: 20px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            min-width: 400px;
            padding: 10px 40px;
            text-align: left;
        }
        .card h1 {
            font-size: 24px;
            font-weight: 600;
        }
        h1 {
            text-align: center;
        }
        .mb-4 {
            margin-bottom: 15px;
        }

        .mb-2 {
            font-size: 14px;
            color: #666666;
            margin-bottom: 4px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            font-size: 16px;
            color: #333;
            border: 1px solid #B06AB3;
            border-radius: 5px;
            background-color: #ffffff;
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: #000000;
            outline: none;
            background-color: #ffffff;
        }

        .btn-primary {
            background-color: #8c2c68;
            color: #ffffff;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #6a3458;
        }

        .text-muted {
            color: #666;
            font-size: 14px;
            text-align: center;
            margin-top: 15px;
        }

        .text-light {
            color: #7a0350;
            text-decoration: none;
        }

        .d-grid {
            display: flex;
            justify-content: center;
            margin-top: 13px;
            margin-bottom: 5px;
        }
    </style>

    <div class="container h-100 m-3">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-xl-8 col-md-10">

                <div class="card shadow-lg p-4">
                    <div class="card-body">
                        <form action="/auth/register" method="post">
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}"
                                       value="${(_csrf.token)!'--no-token--'}"/>
                            </#if>
                            <h1 class="text-center mb-4">Регистрация</h1>
                            <div class="mb-4">
                                <h6 class="mb-2">Email</h6>
                                <@spring.formInput "userDto.email" 'class="form-control form-control-lg"' />
                                <@spring.showErrors "<br>" "text-danger" />
                            </div>

                            <div class="mb-4">
                                <h6 class="mb-2">Пароль</h6>
                                <@spring.formInput "userDto.password" 'type="password" class="form-control form-control-lg"' />
                                <@spring.showErrors "<br>" "text-danger" />
                            </div>

                            <div class="mb-4">
                                <h6 class="mb-2">Район</h6>
                                <@spring.formInput "userDto.district" 'class="form-control form-control-lg"' />
                                <@spring.showErrors "<br>" "text-danger" />
                            </div>

                            <div class="mb-4">
                                <h6 class="mb-2">Номер телефона</h6>
                                <@spring.formInput "userDto.phoneNumber" 'class="form-control form-control-lg"' />
                                <@spring.showErrors "<br>" "text-danger" />
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">Зарегистрироваться</button>
                            </div>

                        </form>
                    </div>
                </div>
                <div class="text-center mt-4">
                    <p class="text-muted">Уже есть аккаунт? <a href="/auth/login" class="text-light">Войти</a></p>
                </div>
            </div>
        </div>
    </div>
</@layout.layout>

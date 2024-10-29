<#import '../layout.ftlh' as layout>
<@layout.layout ; spring>

    <section class="text-center text-lg-start">

        <style>
            body {
                background: linear-gradient(#d9a7c7, #fffcdc);
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0;
                color: #333;
                font-family: Arial, sans-serif;
            }

            .card {
                background-color: rgba(255, 255, 255, 0.9);
                border-radius: 20px;
                backdrop-filter: blur(10px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                width: 100%;
                min-width: 400px;

                padding: 60px 30px;
                text-align: left;
            }

            .card h1 {
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


            .form-label {
                color: #555;
                font-size: 14px;
                margin-bottom: 5px;
                display: block;
            }

            .btn-primary, .btn-secondary {
                border: none;
                border-radius: 10px;
                padding: 12px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
                width: 100%;
                margin: 15px 0;

            }

            .btn-primary {
                background-color: #7a0350;
                color: #ffffff;
            }

            .btn-primary:hover {
                background-color: #8c2c68;
                transform: scale(1.05);
            }

            .btn-secondary {
                margin-top: 20px;
                color: black;
                margin-left: 150px;
            }

            .btn-secondary:hover {
                color: #7a0350;
                transform: scale(1.05);
            }
        </style>

        <div class="card m-3">
            <div class="row g-0 d-flex align-items-center h-100">
                <div class="col-lg-8 mx-auto">
                    <div class="card-body py-5 px-md-3">
                        <h1 class="mb-4">Вход в систему</h1>
                        <form id="login-form" action="/auth/login" method="post">

                            <!-- CSRF -->
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                       value="${(_csrf.token)!'csrf-token'}"/>
                            </#if>

                            <!-- Email input -->
                            <div class="form-outline">
                                <input type="email" id="form2Example1" class="form-control" name="username" required/>
                                <label class="form-label" for="form2Example1">Email адрес</label>
                            </div>

                            <!-- Password input -->
                            <div class="form-outline">
                                <input type="password" id="form2Example2" class="form-control" name="password" required/>
                                <label class="form-label" for="form2Example2">Пароль</label>
                            </div>

                            <!-- Submit button -->
                            <button type="submit" class="btn btn-primary btn-block mb-4">Войти</button>
                            <a href="/auth/forgot_password" class="btn btn-secondary btn-block mb-4">Забыли пароль?</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</@layout.layout>

<#import '../layout.ftlh' as layout>
<@layout.layout ; spring>

    <section class=" text-center text-lg-start">

        <style>

            .rounded-t-5 {

                border-top-left-radius: 0.5rem;

                border-top-right-radius: 0.5rem;

            }



            @media (min-width: 992px) {

                .rounded-tr-lg-0 {

                    border-top-right-radius: 0;

                }



                .rounded-bl-lg-5 {

                    border-bottom-left-radius: 0.5rem;

                }

            }

        </style>

        <div class="card m-3">

            <div class="row g-0 d-flex align-items-center">

                <div class="col-lg-4 d-none d-lg-flex">

                    <img src="data:image/jpeg;base64,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" alt="Trendy Pants and Shoes"

                         class="w-100 rounded-t-5 rounded-tr-lg-0 rounded-bl-lg-5"/>

                </div>

                <div class="col-lg-8">

                    <div class="card-body py-5 px-md-5">



                        <form id="login-form" action="/auth/login" method="post">

                            <!-- CSRF -->
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                       value="${(_csrf.token)!'csrf-token'}"/>
                            </#if>

                            <!-- Email input -->
                            <div data-mdb-input-init class="form-outline mb-4">
                                <input type="email" id="form2Example1" class="form-control" name="username"/>
                                <label class="form-label" for="form2Example1">Email address</label>
                            </div>

                            <!-- Password input -->
                            <div data-mdb-input-init class="form-outline mb-4">
                                <input type="password" id="form2Example2" class="form-control" name="password"/>
                                <label class="form-label" for="form2Example2">Password</label>
                            </div>

                            <!-- Submit button -->
                            <button type="submit" data-mdb-button-init data-mdb-ripple-init
                                    class="btn btn-primary btn-block mb-4">Sign in
                            </button>

                            <a href="/auth/forgot_password" class="btn btn-primary btn-block mb-4">Forgot password</a>


                        </form>
                    </div>
                </div>
            </div>
        </div>

    </section>
</@layout.layout>
<#include "security.ftl">
<#macro login path isRegisterForm>
<form action="${path}" method="post" class="col-md-8">

    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

    <#if isRegisterForm>
        <h4>Регистрация</h4>
    <#else>
        <h4>Вход</h4>
    </#if>

    <div class="form-group">
        <label>Имя аккаунта</label>
        <input type="text" name="username" value="<#if user??>${user.username}</#if>"
               class="form-control ${(usernameError??)?string('is-invalid', '')}"
               id="username">
        <#if usernameError??>
            <div class="invalid-feedback">
                ${usernameError}
            </div>
        </#if>
    </div>

    <#if isRegisterForm>
    <div class="form-group">
        <label>Адрес электронной почты</label>
        <input type="email" name="email" value="<#if user??>${user.email}</#if>"
               class="form-control ${(emailError??)?string('is-invalid', '')}"
               id="email">
        <#if emailError??>
            <div class="invalid-feedback">
                ${emailError}
            </div>
        </#if>
    </div>

    <div class="form-group">
        <label>Имя</label>
        <input type="text" name="firstName" value="<#if user??>${user.firstName}</#if>"
               class="form-control ${(firstNameError??)?string('is-invalid', '')}"
               id="firstName">
        <#if firstNameError??>
            <div class="invalid-feedback">
                ${firstNameError}
            </div>
        </#if>
    </div>

    <div class="form-group">
        <label>Фамилия</label>
        <input type="text" name="lastName" value="<#if user??>${user.lastName}</#if>"
               class="form-control ${(lastNameError??)?string('is-invalid', '')}"
               id="lastName">
        <#if lastNameError??>
            <div class="invalid-feedback">
                ${lastNameError}
            </div>
        </#if>
    </div>
        <div class="form-group">
            <label>Телефон</label>
            <input
                    type="number"
            <#--  type="tel" name="phone"-->
            <#--pattern="[0-9]{1}-[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}"-->
                    value="<#if user??>${user.phone}</#if>"
                    class="form-control ${(phoneError??)?string('is-invalid', '')}"
                    id="phone">
        <#if lastNameError??>
            <div class="invalid-feedback">
                ${lastNameError}
            </div>
        </#if>
        </div>
    </#if>

    <div class="form-group">
        <label>Пароль</label>
        <input type="password" name="password"
               class="form-control ${(passwordError??)?string('is-invalid', '')}"
               id="password">
        <#if passwordError??>
            <div class="invalid-feedback">
                ${passwordError}
            </div>
        </#if>
    </div>

    <#if isRegisterForm>
     <div class="form-group">
         <label>Повторите пароль</label>
         <input type="password" name="confirmPassword"
                class="form-control ${(confirmPasswordError??)?string('is-invalid', '')}"
                id="confirmPassword">
        <#if confirmPasswordError??>
            <div class="invalid-feedback">
                ${confirmPasswordError}
            </div>
        </#if>
     </div>
    </#if>

    <#if !isRegisterForm>
    <div class="form-group">
        <a href="/registration">Создать аккаунт</a>
    </div>
    </#if>

    <button class="btn btn-primary" type="submit">
        <#if isRegisterForm>Зарегистрироваться<#else>Войти</#if>
    </button>

</form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-light" type="submit">
            <#if user??>Выйти<#else>Войти</#if>
        </button>
    </form>
</#macro>
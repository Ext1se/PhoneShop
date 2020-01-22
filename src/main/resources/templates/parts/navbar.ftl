<#include "security.ftl">
<#import "login.ftl" as login>

<nav class="navbar navbar-expand-lg navbar-dark bg-secondary" style="background-color: rgba(255, 255, 255, 0.8)">
    <a class="navbar-brand " href="/">
        <img src="/images/logo.png" width="40" height="40" class="d-inline-block align-top" alt="">
        <span class="align-middle">Super Gadget</span>
    <#--<span>Smart Gadget</span>-->
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Главная</a>
            </li>
            <#if user??>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="lkNavDropdown"
                   role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Личный кабинет
                </a>
                <div class="dropdown-menu" aria-labelledby="lkNavDropdown">
                    <a class="dropdown-item" href="/user/profile/">Профиль</a>
                    <a class="dropdown-item" href="/orders-user/">Заказы</a>
                </div>
            </li>
            </#if>
            <#if isAdmin>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                   role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Компоненты
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <h6 class="dropdown-header">Основные компоненты</h6>
                    <a class="dropdown-item" href="/admin/cpunits">CPU</a>
                    <a class="dropdown-item" href="/admin/gpunits">GPU</a>
                    <a class="dropdown-item" href="/admin/displays">Дисплеи</a>
                    <a class="dropdown-item" href="/admin/display-types">Типы дисплеев</a>
                    <a class="dropdown-item" href="/admin/cameras">Камеры</a>
                    <a class="dropdown-item" href="/admin/materials">Материалы корпусов</a>
                    <div class="dropdown-divider"></div>
                    <h6 class="dropdown-header">Дополнительные компоненты</h6>
                    <a class="dropdown-item" href="/admin/oss">Операционные системы</a>
                    <a class="dropdown-item" href="/admin/companies">Производители</a>
                    <a class="dropdown-item" href="/admin/resolutions">Разрешения</a>
                    <a class="dropdown-item" href="/admin/colors">Цвета</a>
                </div>
            </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="phonesNavDropdown"
                       role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Управление телефонами
                    </a>
                    <div class="dropdown-menu" aria-labelledby="phonesNavDropdown">
                        <a class="dropdown-item" href="/admin/models">Модели</a>
                        <a class="dropdown-item" href="/admin/smartphones">Телефоны</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/admin/model">Создать модель</a>
                    </div>
                </li>
            <li class="nav-item">
                <a class="nav-link" href="/orders/">Заказы</a>
            </li>

            <#--   <li class="nav-item">
                   <a class="nav-link" href="/user">Пользователи</a>
               </li>-->
            </#if>
            <li class="nav-item">
                <a class="nav-link" href="/about/">О сайте</a>
            </li>
        <#--<#if user??>
        <li class="nav-item">
            <a class="nav-link" href="/bucket/">Корзина</a>
        </li>
        </#if>-->
        </ul>

        <div class="navbar-text mr-3">
        <i>${name}</i>
        </div>
        <#if user??>
            <button class=" btn btn-info mr-2"
                    onclick="window.location.href = '/bucket/'" >
                <span class="fas fa-shopping-cart mr-2"></span>Корзина</button>
        </#if>
        <@login.logout/>
    </div>
</nav>
<div class="dropdown-divider mt-0"></div>


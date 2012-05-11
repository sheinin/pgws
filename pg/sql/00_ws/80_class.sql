/*

    Copyright (c) 2010, 2012 Tender.Pro http://tender.pro.

    This file is part of PGWS - Postgresql WebServices.

    PGWS is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    PGWS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with PGWS.  If not, see <http://www.gnu.org/licenses/>.

*/
-- 80_class.sql - Данные классов и акций
/* ------------------------------------------------------------------------- */
\qecho '-- FD: pgws:ws:80_class.sql / 23 --'

/* ------------------------------------------------------------------------- */
INSERT INTO class (id, up_id, id_count, is_ext, sort, code, name) VALUES
  (1, NULL, DEFAULT, FALSE, '1', 'system', 'Система')  -- акции могут зависеть от пользователя или статуса системы
 ,(2, NULL, DEFAULT, FALSE, '2', 'info', 'Информация') -- акции всем всегда доступны
;

/* ------------------------------------------------------------------------- */
INSERT INTO class_status (class_id, id, sort, name) VALUES
  (1, 1, '11', 'Онлайн')
 ,(1, 2, '12', 'На обслуживании')
 ,(2, 1, '21', 'Онлайн')
;

/* ------------------------------------------------------------------------- */
INSERT INTO class_action (class_id, id, sort, name) VALUES
  (1, 1, '11', 'Чтение онлайн')
 ,(1, 2, '12', 'Авторизованное чтение')
 ,(1, 3, '13', 'Системное чтение')
 ,(1, 4, '14', 'Авторизованная запись')
 ,(1, 5, '15', 'Управление')
 ,(1, 6, '16', 'Обслуживание')
 ,(1, 7, '17', 'Использование онлайн') -- чтение и запись динамики
 ,(1, 8, '18', 'Только для неавторизованных')
 ,(2, 1, '21', 'Публичное чтение')
;
/* ------------------------------------------------------------------------- */
/* comment SQL:
select ',('||class_id||', '||status_id||', '||action_id||') -- '||class||' - '||status||' - '||action
from ws.csa order by class_id,status_id,action_id;
*/

INSERT INTO class_status_action (class_id, status_id, action_id) VALUES
  (1, 1, 1) -- Система - Онлайн - Чтение онлайн
 ,(1, 1, 2) -- Система - Онлайн - Авторизованное чтение
 ,(1, 1, 3) -- Система - Онлайн - Системное чтение
 ,(1, 1, 4) -- Система - Онлайн - Авторизованная запись
 ,(1, 1, 5) -- Система - Онлайн - Управление
 ,(1, 1, 7) -- Система - Онлайн - Использование онлайн
 ,(1, 2, 2) -- Система - На обслуживании - Авторизованное чтение
 ,(1, 2, 3) -- Система - На обслуживании - Системное чтение
 ,(1, 2, 5) -- Система - На обслуживании - Управление
 ,(1, 2, 6) -- Система - На обслуживании - Обслуживание
 ,(2, 1, 1) -- Информация - Онлайн - Публичное чтение
;

/* ------------------------------------------------------------------------- */
INSERT INTO class_acl (class_id, id, is_sys, sort, name) VALUES
  (1, 1, true, '11', 'Неавторизованный пользователь')
 ,(1, 2, true, '12', 'Авторизованный пользователь')
 ,(1, 3, true, '13', 'Сервис')
 ,(1, 4, true, '14', 'Администратор')
 ,(2, 1, true, '21', 'Любой пользователь')
;

/* ------------------------------------------------------------------------- */
/* comment SQL:
select ',('||class_id||', '||action_id||', '||acl_id||') -- '||class||' - '||action||' - '||acl
from ws.caa order by class_id,action_id,acl_id;
*/
INSERT INTO class_action_acl (class_id, action_id, acl_id) VALUES
  (1, 1, 1) -- Система - Чтение онлайн - Неавторизованный пользователь
 ,(1, 1, 2) -- Система - Чтение онлайн - Авторизованный пользователь
 ,(1, 1, 3) -- Система - Чтение онлайн - Сервис
 ,(1, 1, 4) -- Система - Чтение онлайн - Администратор
 ,(1, 2, 2) -- Система - Авторизованное чтение - Авторизованный пользователь
 ,(1, 3, 3) -- Система - Системное чтение - Сервис
 ,(1, 3, 4) -- Система - Системное чтение - Администратор
 ,(1, 4, 2) -- Система - Авторизованная запись - Авторизованный пользователь
 ,(1, 5, 4) -- Система - Управление - Администратор
 ,(1, 6, 4) -- Система - Обслуживание - Администратор
 ,(1, 7, 1) -- Система - Использование онлайн - Неавторизованный пользователь
 ,(1, 7, 2) -- Система - Использование онлайн - Авторизованный пользователь
 ,(2, 1, 1) -- Информация - Публичное чтение - Любой пользователь
;


/* ------------------------------------------------------------------------- */
\qecho '-- FD: pgws:ws:80_class.sql / 102 --'

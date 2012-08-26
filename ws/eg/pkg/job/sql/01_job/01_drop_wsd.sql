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

    Удаление данных из схемы ws
*/

/* ------------------------------------------------------------------------- */
DELETE FROM wsd.prop_value WHERE pkg = :'PKG';
DELETE FROM wsd.prop_owner WHERE pkg = :'PKG';
DELETE FROM wsd.prop_group WHERE pkg = :'PKG';

DELETE FROM ws.prop                 WHERE pkg = :'PKG';
UPDATE ws.prop SET pogc_list = ws.array_remove(pogc_list::text[], 'job') WHERE 'job' = ANY(pogc_list);

/* ------------------------------------------------------------------------- */
DROP TABLE wsd.job;
DROP TABLE wsd.job_todo;
DROP TABLE wsd.job_past;
DROP TABLE wsd.job_dust;

DROP SEQUENCE wsd.job_seq;
/* ------------------------------------------------------------------------- */
DELETE FROM wsd.pkg_script_protected WHERE pkg = :'PKG';

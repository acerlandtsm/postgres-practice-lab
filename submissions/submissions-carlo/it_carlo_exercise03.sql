-- Object Exercise 1: Create table project_assignments with PK and FKs to employees/departments. --done
-- Object Exercise 2: Add check constraint for allocation_percent between 0 and 100. --done
-- Object Exercise 3: Add index on employee_id.
-- Object Exercise 4: Create sequence for external reference numbers. --done
-- Object Exercise 5: Create view for active assignments. --done
-- Object Exercise 6: Create function returning assignment count by department.


SELECT *
FROM employees

SELECT *
FROM departments

--Exercise 1 & 2
--Created using pgAdmin 4 GUI
CREATE TABLE public.project_assignments
(
    pk_project_id integer,
    proj_name character varying(100),
    employee_id integer,
    department_id integer,
    start_date timestamp without time zone DEFAULT now(),
    project_budget numeric(12, 2),
    is_active boolean,
    allocation_percent numeric(5, 2),
    CONSTRAINT pk_project_id PRIMARY KEY (pk_project_id),
    CONSTRAINT employee_id FOREIGN KEY (employee_id)
        REFERENCES public.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT department_id FOREIGN KEY (department_id)
        REFERENCES public.departments (department_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT allocation_percent CHECK (allocation_percent >= 0 AND allocation_percent <= 100) NOT VALID
);

ALTER TABLE IF EXISTS public.project_assignments
    OWNER to eaaranzamendez;

ALTER TABLE IF EXISTS public.project_assignments
    OWNER to eaaranzamendez;

--Exercise 3
ALTER INDEX IF EXISTS public.idx_employee_id
    RENAME TO idx_employee_i;

--Exercise 4
CREATE SEQUENCE public.ref_number_seq
    INCREMENT 1
    START 1001
    MINVALUE 1001
    MAXVALUE 3000
    CACHE 1;

ALTER SEQUENCE public.ref_number_seq
    OWNER TO eaaranzamendez;

--Exercise 5
CREATE VIEW public.vw_active_assignments
 AS
SELECT COUNT(is_active) AS active_projects
FROM project_assignments
WHERE is_active = TRUE;

ALTER TABLE public.vw_active_assignments
    OWNER TO eaaranzamendez;

--Exercise 6
CREATE OR REPLACE FUNCTION public.fn_count_department_proj(IN boolean)
    RETURNS TABLE(department_code character varying, department_name character varying, active_projects_count integer)
    LANGUAGE 'sql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100    ROWS 1000 
    
AS $BODY$
	SELECT
		d.department_code,
		d.department_name,
		COUNT(pr.pk_project_id) 
		FILTER (WHERE pr.is_active = TRUE) AS active_projects_count
	FROM departments AS d
	LEFT JOIN project_assignments AS pr
		ON d.department_id = pr.department_id
	GROUP BY d.department_code, d.department_name;

		
$BODY$;



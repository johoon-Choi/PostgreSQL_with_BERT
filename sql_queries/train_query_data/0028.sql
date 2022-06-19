\o out.txt
SET random_page_cost = 32;

\timing

select
	c_name,
	c_custkey,
	o_orderkey,
	o_orderdate,
	o_totalprice
from
	customer,
	orders,
	lineitem
where
	o_orderkey not in (
		select
			l_orderkey
		from
			lineitem
		group by
			l_orderkey having
				sum(l_quantity) > 100
	)
	and c_custkey = o_custkey
	and o_orderkey = l_orderkey
group by
	c_name,
	c_custkey,
	o_orderkey,
	o_orderdate,
	o_totalprice
order by
	o_totalprice desc,
	o_orderdate;

\timing

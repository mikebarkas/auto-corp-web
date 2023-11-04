% include('head.tpl', title='Search by price')
% include('header.tpl')

<div class="content">

%if method == 'GET':

    <h3>Search Vehicles by price</h3>
    <p>Select the maximum price</p>

    <form action="/search/price" method="post">
        <select name="price">
            <option value="10000">$10,000</option>
            <option value="12000">$12,000</option>
            <option value="15000">$15,000</option>
            <option value="18000">$18,000</option>
            <option value="20000">$20,000</option>
            <option value="25000">$25,000</option>
            <option value="50000">$50,000</option>
            <option value="100000">$100,000</option>
        </select>
        <input type="submit" value="Search"/>
    </form>

%else:

    %if results > 0:
        <h3>There are {{ results }} vehicles priced under {{ price }}</h3>
        % include('table.tpl', data=data)
    %else:
        <p>There are no results to display</p>
    %end

%end
</div>

% include('footer.tpl')

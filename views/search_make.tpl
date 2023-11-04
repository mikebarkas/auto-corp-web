% include('head.tpl', title='Search by make')
% include('header.tpl')

<div class="content">

%if method == 'GET':

    <h3>Search Vehicles by Make</h3>

    <form action="/search/make" method="post">
        <select id="make" name="make">
            <option value="Ford">Ford</option>
            <option value="Chevrolet">Chevrolet</option>
            <option value="Subaru">Subaru</option>
            <option value="BMW">BMW</option>
            <option value="Hyundai">Hyundai</option>
            <option value="Mitsubishi">Mitsubishi</option>
            <option value="Porsche">Porsche</option>
            <option value="Audi">Audi</option>
            <option value="Nissan">Nissan</option>
            <option value="Mercedes">Mercedes</option>
            <option value="Jeep">Jeep</option>
            <option value="Alfa Romeo">Alfa Romeo</option>
            <option value="Range Rover">Range Rover</option>
        </select>
        <input type="submit" value="Search"/>
    </form>

%else:

    %if results > 0:
        <h3>There are {{ results }} {{ make }} vehicles</h3>
        % include('table.tpl', data=data)
    %else:
        <p>There are no results to display</p>
    %end

%end
</div>

% include('footer.tpl')

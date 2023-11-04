<table>
<tr>
    <th>Year</th>
    <th>Model</th>
    <th>Color</th>
    <th>Price</th>
    <th>Mileage</th>
</tr>
%for d in data:
    <tr>
        <td>{{ d['year'] }}</td>
        <td>{{ d['model'] }}</td>
        <td>{{ d['color'] }}</td>
        <td>{{ d['price'] }}</td>
        <td>{{ d['mileage'] }}</td>
    </tr>
%end
</table>
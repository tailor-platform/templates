# Assumed Use Cases
- Use `addBrand` to add a new Brand.  
    - Upon doing this, a new Brand Group will be created.
- Use `addBrandUser` to add a User to the above Brand Group.  
    - The User will be added to the corresponding Brand Group created earlier.
- Login as a specific Brand User and use `addBrandProduct` to add a Product to the Brand.  
    - When adding the Product, the User's Brand Group permissions are assigned to the newly added Product. As a result, only Users belonging to a specific Brand Group can perform Read, Update, and Delete (RUD) actions on Products under that specific Brand.
- The pipeline for `category` and `attributes` has not been constructed yet. It is currently not deemed necessary to restrict access based on data permissions.


## Usage

To deploy this template, please refer to the instructions in the [console](https://console.tailor.tech/).

To seed the initial data for your application, run these commands.
```bash
tailorctl app login -u '$owner_username' -p '$owner_password' #your workspace owner name and password
tailorctl app import -m charts --auto-approve
tailorctl app login -u 'adminadmin' -p 'adminadmin'
tailorctl app import -m charts/seed --auto-approve
```
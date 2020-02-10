$('#projects').DataTable({
       ajax: "http://localhost:4567/projects", 
       paging: true,
        pageLength: 50,
        serverSide: true,
        processing: true,
        ordering: false,
        responsive: true,
        columns: [
            { data: 'name' },
            { data: 'description' }
        ]
    });
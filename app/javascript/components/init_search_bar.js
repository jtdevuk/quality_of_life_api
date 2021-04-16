const initSearchBar = () => {
  const searchBar = document.getElementById('search-bar')
  if(searchBar) {
    searchBar.addEventListener('keyup', function(){
      console.log('keyup')
    })
  }
}

export { initSearchBar }
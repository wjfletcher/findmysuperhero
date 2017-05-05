import React, { Component }  from 'react';
import Autocomplete from 'react-google-autocomplete';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      heroesnearboston: null
    };
    this.getHeroes = this.getHeroes.bind(this);
  }


  componentDidMount() {
    this.getHeroes();
  }

  // make call to api to get heroes
  getHeroes () {
    fetch(`/api/v1/heroes`, {
      credentials: 'same-origin'
    })
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status}, (${response.statusText})`;
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({
          heroesnearboston: body.heroesnearboston
        });
      });
  }

  render() {

    let heroesnearboston = this.state.heroesnearboston;
    // show heroes once api request complete
    if (heroesnearboston != null){
      heroesnearboston = heroesnearboston.map((hero, i) => {
        if (Math.round(hero[1]) < 25) {
          return (
            <h4 key={i}>{hero[0]} is in Boston!</h4>
          )
        } else {
          return (
            <h4 key={i}>{hero[0]} is about {Math.round(hero[1])} miles away</h4>
          )
        }

      });
    // if api request not complete, show loading animation
    } else {
      return (
        <div>
          <p>Please wait while the database initializes</p>
          <i className="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
          <span className="sr-only">Loading...</span>
        </div>
      )
    }
    return(
      <div>
        <h1>Heroes within 500 miles of Boston:</h1>
        {heroesnearboston}
        <Autocomplete
          style={{width: '90%'}}
          onPlaceSelected={(place) => {
            console.log(place);
          }}
          types={['(regions)']}
          // componentRestrictions={{country: "ru"}}
        />
      </div>
    )
  }
}

export default App;

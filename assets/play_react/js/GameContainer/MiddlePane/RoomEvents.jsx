import React, { Component } from 'react';
import { connect } from 'react-redux';
import styled from 'styled-components';
import VmlParser from '../../SharedComponents/VmlParser.jsx';

const RoomEventsContainer = styled.div`
  padding: 1em 2em 1em 2em;
  height: 100%;
  overflow-y: scroll;
`;

class RoomEvents extends Component {
  constructor(props) {
    super(props);
    this.scrollToBottom = this.scrollToBottom.bind(this);
  }
  scrollToBottom() {
    this.messagesEnd.scrollIntoView({ behavior: 'smooth' });
  }

  componentDidMount() {
    this.scrollToBottom();
  }

  componentDidUpdate() {
    this.scrollToBottom();
  }
  render() {
    return (
      <RoomEventsContainer>
        <div>
          {this.props.eventStream.map(event => {
            return <VmlParser key={event.sent_at} vmlString={event.message} />;
          })}
          <div
            ref={el => {
              this.messagesEnd = el;
            }}
          />
        </div>
      </RoomEventsContainer>
    );
  }
}

const mapStateToProps = ({ eventStream }) => {
  return { eventStream };
};

export default connect(mapStateToProps)(RoomEvents);

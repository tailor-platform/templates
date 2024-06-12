import React, { MouseEventHandler } from 'react'
import { type FC } from 'react'
import { Retool } from '@tryretool/custom-component-support'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEnvelope, faFile, faNoteSticky, faStar } from '@fortawesome/free-regular-svg-icons';
import Moment from 'moment';
import { faCheck } from '@fortawesome/free-solid-svg-icons';

type TimelineEntry = Retool.SerializableObject & {
      id: string;
      sourceID: string;
      sourceType: string;
      eventName: string;
      eventType: EventType;
      objectType: string;
      objectID: string;
      messageSegments: {
        text: string;
        type: string;
        linkedObjectType: string;
        linkedObjectID: string;
        dateValue: string;
      }[]
      createdAt: string;
};

type EventType = "activity" | "note" | "correspondence" | "task" | "documents" | "changelog";

const listItemStyle: React.CSSProperties = {
          borderLeft: '1px dashed #ccc',
          minHeight: '100px',
          paddingLeft: '32px',
          position: 'relative',
        };

const noteStyle: React.CSSProperties = {
  backgroundColor: '#ffedac',
  borderRadius: '5px',
  padding: '10px',
}

const cardStyle: React.CSSProperties = {
  backgroundColor: '#f8f9fa',
  borderRadius: '5px',
  padding: '10px',
}

const primaryCardStyle: React.CSSProperties = {
  backgroundColor: '#f8f9fa',
  borderRadius: '5px',
  padding: '10px',
  border: '1px solid #007bff',
}

export const TailorTimeline: FC = () => {
  const [data, _setData] = Retool.useStateArray({
    name: 'data',
    initialValue: [],
    label: 'Data',
  });
  const [newNote, setNewNote] = Retool.useStateString({
    name: 'newNote',
    initialValue: '',
    label: 'New Note',
  });
  const [linkedObjectId, setLinkedObjectId] = Retool.useStateString({
    name: 'linkedObjectId',
    initialValue: '',
    label: 'Linked Object ID',
  });
  const [linkedObjectType, setLinkedObjectType] = Retool.useStateString({
    name: 'linkedObjectType',
    initialValue: '',
    label: 'Linked Object Type',
  });
  const onSaveNote = Retool.useEventCallback({ name: 'saveNote' })
  const onLinkClick = Retool.useEventCallback({ name: 'onLinkClick' })
  function handleClick(object: {
    objectId: string,
    objectType: string
  }): MouseEventHandler {
    return (e) => {
      e.preventDefault();
      setLinkedObjectId(object.objectId);
      setLinkedObjectType(object.objectType);
      onLinkClick();
    }}
  const listItems = data.map((item: TimelineEntry | Retool.SerializableType, index) => {
    const newLineToBr = (text: string) => {
      return text.split('\n').map((str, index) => {
        return (
          <span>
            {str}
            <br />
          </span>
        )
      });
    }
    const message = (item as TimelineEntry).messageSegments.map((segment) => {
      switch (segment.type) {
        case 'text':
          return (<span className='me-2'> {newLineToBr(segment.text)} </span>);
        case 'link':
          return (<a href="#" onClick={handleClick({objectId: segment.linkedObjectID, objectType: segment.linkedObjectType})}
           >{segment.text}</a>);
        case 'date':
          return (<span> on {Moment(segment.dateValue).format('MMM, DD yyyy')} </span>);
      }
    });
    switch ((item as TimelineEntry).eventType) {
      case 'note':
        return (
          <li key={index} style={listItemStyle}>
            <EntryIcon eventType={(item as TimelineEntry).eventType} />
            <div style={{ ...noteStyle }}>
              <div style={{
                color: '#999',
                fontSize: '10px',
                marginBottom: '5px',
                whiteSpace: 'nowrap',
              }}>{Moment((item as TimelineEntry).createdAt).fromNow()} • Aladdin</div>
              <div>{message}</div>
            </div>
          </li>
        );
      case 'activity':
        return (
          <li key={index} style={listItemStyle}>
            <EntryIcon eventType={(item as TimelineEntry).eventType} />
            <div style={cardStyle}>
              <div
                style={{
                  color: '#999',
                  fontSize: '10px',
                  marginBottom: '5px'
                }}
              >
                {Moment((item as TimelineEntry).createdAt).fromNow()} • Aladdin
              </div>
              {message}
            </div>
          </li>
        )
      case 'correspondence':
        return (
          <li key={index} style={listItemStyle}>
            <EntryIcon eventType={(item as TimelineEntry).eventType} />
            <div style={primaryCardStyle}>
              <div
                style={{
                  color: '#999',
                  fontSize: '10px',
                  marginBottom: '5px'
                }}
              >
                {Moment((item as TimelineEntry).createdAt).fromNow()} • Aladdin
              </div>
              {message}
            </div>
          </li>
        )
      default:
        return (
          <li key={index} style={listItemStyle}>
            <EntryIcon eventType={(item as TimelineEntry).eventType} />
            <div
              style={{
                paddingTop: '10px'
              }}
            >
              {message}
            </div>
          </li>
        );
    }

  });

  return (
    <div style={
      {
        fontFamily: '"Inter var", Inter, -apple-system, "system-ui", system-ui, "Segoe UI", Roboto, "Helvetica Neue", Ubuntu, sans-serif',
        fontSize: '12px',
        fontWeight: 400,
        position: 'relative',
        height: '100%',
        overflow: 'scroll-y',
      }
    }>
        <ul style={{
          listStyle: 'none',
          paddingRight: '24px',
        }}>
          <NewNote setNewNote={setNewNote} value={newNote} onSave={onSaveNote} />
          {listItems}
        </ul>
    </div>
  )
}

function NewNote(props: {setNewNote: (note: string) => void, value: string, onSave: () => void}) {
  const updateNote = (note: string) => {
    props.setNewNote(note);
  }
  return (
    <li style={listItemStyle}>
      <EntryIcon eventType="note" />
      <div
        style={{
          ...noteStyle,
        }}
      >
        <div>
          <textarea
            style={{
              width: '100%',
              backgroundColor: 'transparent',
              border: 'none',
              resize: 'vertical',
              outline: 'none'
            }}
            rows={5}
            placeholder="Write a note..."
            onChange={(e) => updateNote(e.target.value)}
            value={props.value}
          ></textarea>
        </div>
        <div>
          <button
            style={{
              backgroundColor: '#ffd24a',
              color: 'white',
              border: 'none',
              padding: '5px 10px',
              borderRadius: '5px',
              cursor: 'pointer',
              marginTop: '5px'
            }}
            onClick={props.onSave}
          >
            Save
          </button>
        </div>
      </div>
      <div style={{height: "10px"}}></div>
    </li>
  )
}

function EntryIcon(props: { eventType: EventType }) {
  const iconStyle: React.CSSProperties = {
    borderRadius: '50%',
    border: '1px solid #ccc',
    backgroundColor: '#f8f9fa',
    width: '36px',
    height: '36px',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    position: 'absolute',
    left: '-19px',
    boxShadow: '0 0 5px 2px #eee'
  };
  const noIconStyle: React.CSSProperties = {
    borderRadius: '50%',
    border: '1px solid #ccc',
    backgroundColor: '#f8f9fa',
    width: '12px',
    height: '12px',
    position: 'absolute',
    left: '-7px',
    top: '12px',
    boxShadow: '0 0 5px 2px #eee'
  };


  switch (props.eventType) {
    case 'changelog':
      return <div style={noIconStyle}></div>;
    case 'note':
      return (
        <div
          style={iconStyle}
        >
          <FontAwesomeIcon icon={faNoteSticky} />
        </div>
      );
    case 'activity':
      return (
        <div
          style={iconStyle}
        >
          <FontAwesomeIcon icon={faStar} />
        </div>
      );
    case 'correspondence':
      return (
        <div
          style={iconStyle}
        >
          <FontAwesomeIcon icon={faEnvelope} />
        </div>
      );
    case 'task':
      return (
        <div
          style={iconStyle}
        >
          <FontAwesomeIcon icon={faCheck} />
        </div>
      );
    case 'documents':
      return (
        <div
          style={iconStyle}
        >
          <FontAwesomeIcon icon={faFile} />
        </div>
      )
    default:
      return <div style={noIconStyle}></div>;
  }
}

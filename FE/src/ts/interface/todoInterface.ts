interface ITodoViewTemplate {
    id: string;
    title: string;
    content: string;
    cards: [];
    sections: [];
}

interface ICardOption {
    dragTarget: HTMLElement | null;
    targetHeight: number | null;
    toTarget: HTMLElement | null;
    toTargetWrap: HTMLElement | null;
    prevColumn: HTMLElement | null;
    currColumn: HTMLElement | null;
}

interface IOnClickSubmit {
    event: Event;
    parentClassName: string;
    type: string;
    callback: Function;
}

export { ITodoViewTemplate, ICardOption, IOnClickSubmit };
